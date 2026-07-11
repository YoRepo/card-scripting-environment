--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Pyramid of Wonders  (ID: 66835946)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- All Zombie monsters you control gain 200 ATK for each monster your opponent controls.
-- If exactly 1 Zombie monster you control (and no other cards) would be destroyed, you can send this
-- card to the GY instead.
--[[ __CARD_HEADER_END__ ]]

--奇跡のピラミッド
function c66835946.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ZOMBIE))
	e2:SetValue(c66835946.val)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c66835946.destg)
	e3:SetValue(1)
	e3:SetOperation(c66835946.desop)
	c:RegisterEffect(e3)
end
function c66835946.val(e,c)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)*200
end
function c66835946.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local tc=eg:GetFirst()
		return eg:GetCount()==1 and tc:IsLocation(LOCATION_MZONE) and tc:IsControler(tp) and tc:IsFaceup() and tc:IsRace(RACE_ZOMBIE)
			and not tc:IsReason(REASON_REPLACE)
	end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c66835946.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
