--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 魔救之奇石-巨龙晶石  (ID: 10286023)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Rock
-- Level 4
-- ATK 0 | DEF 2200
-- Setcode: 320
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡用「魔救」卡的效果特殊召唤成功的场合才能发动。自己从卡组抽1张。
-- ②：这张卡在墓地存在的场合，以自己的场上·墓地1只水属性同调怪兽为对象才能发动。那只怪兽回到持有者的额外卡组，这张卡回到卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--魔救の奇石－ドラガイト
function c10286023.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10286023,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,10286023)
	e1:SetCondition(c10286023.drcon)
	e1:SetTarget(c10286023.drtg)
	e1:SetOperation(c10286023.drop)
	c:RegisterEffect(e1)
	--to decktop
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10286023,1))
	e2:SetCategory(CATEGORY_TOEXTRA+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,10286024)
	e2:SetTarget(c10286023.dttg)
	e2:SetOperation(c10286023.dtop)
	c:RegisterEffect(e2)
end
function c10286023.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSpecialSummonSetCard(0x140)
end
function c10286023.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10286023.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c10286023.texfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
end
function c10286023.dttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and c10286023.texfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c10286023.texfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,c) and c:IsAbleToDeck() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c10286023.texfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
end
function c10286023.dtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_EXTRA) and c:IsRelateToEffect(e) then
		Duel.SendtoDeck(c,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
