--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 梦幻崩影·独角兽  (ID: 38342335)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Fiend
-- ATK 2200 | LINK
-- Setcode: 274
--
-- Effect Text:
-- 卡名不同的怪兽2只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡连接召唤的场合，丢弃1张手卡，以场上1张卡为对象才能发动。那张卡回到卡组。这个效果的发动时这张卡是互相连接状态的场合，再让自己可以抽1张。
-- ②：只要互相连接状态的「幻崩」怪兽存在，自己抽卡阶段的通常抽卡数量变成那些「幻崩」怪兽种类的数量。
--[[ __CARD_HEADER_END__ ]]

--トロイメア・ユニコーン
function c38342335.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,nil,c38342335.lcheck)
	c:EnableReviveLimit()
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38342335,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,38342335)
	e1:SetCondition(c38342335.tdcon)
	e1:SetCost(c38342335.tdcost)
	e1:SetTarget(c38342335.tdtg)
	e1:SetOperation(c38342335.tdop)
	c:RegisterEffect(e1)
	--draw count
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c38342335.drcon)
	e2:SetValue(c38342335.drval)
	c:RegisterEffect(e2)
end
function c38342335.lcheck(g,lc)
	return g:GetClassCount(Card.GetLinkCode)==g:GetCount()
end
function c38342335.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c38342335.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c38342335.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	if e:GetHandler():GetMutualLinkedGroupCount()>0 then
		e:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
		e:SetLabel(1)
	else
		e:SetCategory(CATEGORY_TODECK)
		e:SetLabel(0)
	end
end
function c38342335.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0
		and tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA)
		and e:GetLabel()==1 and Duel.IsPlayerCanDraw(tp,1)
		and Duel.SelectYesNo(tp,aux.Stringid(38342335,1)) then
		Duel.BreakEffect()
		if tc:IsLocation(LOCATION_DECK) and tc:IsControler(tp) then
			Duel.ShuffleDeck(tp)
		end
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c38342335.drfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x112) and c:GetMutualLinkedGroupCount()>0
end
function c38342335.drcon(e)
	return Duel.GetMatchingGroupCount(c38342335.drfilter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)>0
end
function c38342335.drval(e)
	local g=Duel.GetMatchingGroup(c38342335.drfilter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)
	return g:GetClassCount(Card.GetCode)
end
