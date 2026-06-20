--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 鹰身女妖的羽翼休息  (ID: 39275698)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 100
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己墓地的「鹰身女郎」「鹰身女郎三姐妹」之中以合计3只为对象才能发动。那些卡加入卡组洗切。那之后，自己从卡组抽1张。自己场上有5星以上的「鹰身」怪兽存在的状态发动的场合抽出的数量变成2张。这张卡
-- 的发动后，直到回合结束时自己不是风属性怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ハーピィの羽根休め
function c39275698.initial_effect(c)
	aux.AddCodeList(c,12206212)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c39275698.drtg)
	e1:SetOperation(c39275698.drop)
	e1:SetCountLimit(1,39275698+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end
function c39275698.drfilter(c)
	return c:IsCode(76812113,12206212) and c:IsAbleToDeck()
end
function c39275698.ctfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x64) and c:IsLevelAbove(5)
end
function c39275698.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=1
	if Duel.IsExistingMatchingCard(c39275698.ctfilter,tp,LOCATION_MZONE,0,1,nil) then ct=2 end
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c39275698.drfilter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) and Duel.IsExistingTarget(c39275698.drfilter,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c39275698.drfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	e:SetLabel(ct)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c39275698.drop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if #tg~=0 then
		Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		local g=Duel.GetOperatedGroup()
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
		local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
		if ct>0 then
			Duel.BreakEffect()
			Duel.Draw(tp,e:GetLabel(),REASON_EFFECT)
		end
	end
	local c=e:GetHandler()
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c39275698.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c39275698.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WIND)
end
