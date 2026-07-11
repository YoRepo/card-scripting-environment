--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Neo Flamvell Garuda  (ID: 65156847)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 3
-- ATK 1200 | DEF 1800
-- Setcode: 0x2c
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your End Phase, if you control another "Flamvell" monster: Target 1 card in
-- your opponent's GY; banish it.
--[[ __CARD_HEADER_END__ ]]

--ネオフレムベル・ガルーダ
function c65156847.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65156847,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCondition(c65156847.rmcon)
	e1:SetTarget(c65156847.rmtg)
	e1:SetOperation(c65156847.rmop)
	c:RegisterEffect(e1)
end
function c65156847.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c)
end
function c65156847.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c65156847.filter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c65156847.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),1-tp,LOCATION_GRAVE)
end
function c65156847.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
