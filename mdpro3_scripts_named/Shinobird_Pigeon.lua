--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Shinobird Pigeon  (ID: 92200612)
-- Type: Monster / Effect / Spirit
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1000 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- Once per turn: You can target 1 other Spirit monster on the field; return it to the hand.
-- Once per turn, during the End Phase, if this card was Normal Summoned or flipped face-up this turn:
-- Return it to the hand.
--[[ __CARD_HEADER_END__ ]]

--霊魂鳥－伝鳩
function c92200612.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92200612,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c92200612.thtg)
	e2:SetOperation(c92200612.thop)
	c:RegisterEffect(e2)
end
function c92200612.cfilter(c)
	return c:IsType(TYPE_SPIRIT) and c:IsAbleToHand()
end
function c92200612.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c92200612.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92200612.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c92200612.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c92200612.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
