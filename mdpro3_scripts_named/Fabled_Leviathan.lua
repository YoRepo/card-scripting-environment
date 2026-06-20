--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魔轰神 利威坦  (ID: 39477584)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fiend
-- Level 10
-- ATK 3000 | DEF 2000
-- Setcode: 53
--
-- Effect Text:
-- 「魔轰神」调整＋调整以外的怪兽1只以上
-- ①：场上的这张卡被破坏送去墓地时，以自己墓地最多3只「魔轰神」怪兽为对象才能发动。那些怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔轟神レヴュアタン
function c39477584.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x35),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39477584,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c39477584.con)
	e1:SetTarget(c39477584.tg)
	e1:SetOperation(c39477584.op)
	c:RegisterEffect(e1)
end
function c39477584.con(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_DESTROY)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c39477584.filter(c)
	return c:IsSetCard(0x35) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c39477584.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c39477584.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c39477584.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c39477584.filter,tp,LOCATION_GRAVE,0,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c39477584.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
