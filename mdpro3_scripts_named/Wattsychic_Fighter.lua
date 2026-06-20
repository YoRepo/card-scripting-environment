--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 电气念力斗士  (ID: 81028112)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Psychic
-- Level 3
-- ATK 1500 | DEF 300
-- Setcode: 14
--
-- Effect Text:
-- 「电气念力斗士」的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功时，以对方墓地1张卡为对象才能发动。那张卡回到对方卡组最上面或者最下面。
--[[ __CARD_HEADER_END__ ]]

--エレキック・ファイター
function c81028112.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81028112,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,81028112)
	e1:SetTarget(c81028112.target)
	e1:SetOperation(c81028112.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c81028112.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c81028112.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:IsExtraDeckMonster()
			or Duel.SelectOption(tp,aux.Stringid(81028112,1),aux.Stringid(81028112,2))==0 then
			Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
		else
			Duel.SendtoDeck(tc,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
		end
	end
end
