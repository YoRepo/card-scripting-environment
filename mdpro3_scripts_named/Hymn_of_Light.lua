--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Hymn of Light  (ID: 80566312)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Saffira, Queen of Dragons".
-- You must also Tribute monsters from your hand or field whose total Levels equal 6 or more.
-- If a Ritual Monster(s) you control would be destroyed by battle or card effect, you can banish this
-- card from your GY instead.
--[[ __CARD_HEADER_END__ ]]

--祝祷の聖歌
function c80566312.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,56350972)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c80566312.reptg)
	e1:SetValue(c80566312.repval)
	e1:SetOperation(c80566312.repop)
	c:RegisterEffect(e1)
end
function c80566312.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsType(TYPE_RITUAL)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c80566312.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c80566312.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c80566312.repval(e,c)
	return c80566312.repfilter(c,e:GetHandlerPlayer())
end
function c80566312.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
