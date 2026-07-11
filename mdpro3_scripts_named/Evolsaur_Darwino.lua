--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Evolsaur Darwino  (ID: 39672388)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 5
-- ATK 2200 | DEF 700
-- Setcode: 0x604e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Special Summoned by the effect of an "Evoltile" monster: You can target 1 face-up
-- monster on the field; increase that target's Level by up to 2.
--[[ __CARD_HEADER_END__ ]]

--エヴォルダー・ダルウィノス
function c39672388.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39672388,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(aux.evospcon)
	e1:SetTarget(c39672388.lvtg)
	e1:SetOperation(c39672388.lvop)
	c:RegisterEffect(e1)
end
function c39672388.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(0)
end
function c39672388.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c39672388.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c39672388.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c39672388.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c39672388.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local opt=Duel.SelectOption(tp,aux.Stringid(39672388,1),aux.Stringid(39672388,2))
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(opt+1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
