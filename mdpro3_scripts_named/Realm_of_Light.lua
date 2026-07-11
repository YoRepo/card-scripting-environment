--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Realm of Light  (ID: 36099620)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a card(s) is sent from your Deck to the GY, place 1 Shine Counter on this card.
-- "Lightsworn" monsters gain 100 ATK for each Shine Counter on this card.
-- If this card would be destroyed by card effect, remove 2 Shine Counters from this card instead.
--[[ __CARD_HEADER_END__ ]]

--ジャスティス・ワールド
function c36099620.initial_effect(c)
	c:EnableCounterPermit(0x5)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetOperation(c36099620.acop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x38))
	e3:SetValue(c36099620.atkval)
	c:RegisterEffect(e3)
	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTarget(c36099620.desreptg)
	e4:SetOperation(c36099620.desrepop)
	c:RegisterEffect(e4)
end
function c36099620.atkval(e,c)
	return e:GetHandler():GetCounter(0x5)*100
end
function c36099620.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsPreviousControler(tp)
end
function c36099620.acop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c36099620.cfilter,1,nil,tp) then
		e:GetHandler():AddCounter(0x5,1)
	end
end
function c36099620.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_RULE)
		and e:GetHandler():GetCounter(0x5)>=2 end
	return true
end
function c36099620.desrepop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(ep,0x5,2,REASON_EFFECT)
end
