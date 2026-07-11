--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Alien Kid  (ID: 64160836)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 4
-- ATK 1600 | DEF 700
-- Setcode: 0xc
-- Scope: OCG / TCG
--
-- Effect Text:
-- Place 1 A-Counter on all monsters Special Summoned to your opponent's side of the field.
-- (If a monster with an A-Counter battles an "Alien" monster, it loses 300 ATK and DEF for each
-- A-Counter during damage calculation only.)
--[[ __CARD_HEADER_END__ ]]

--エーリアン・キッズ
function c64160836.initial_effect(c)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c64160836.ctop)
	c:RegisterEffect(e1)
	--atk def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c64160836.adcon)
	e2:SetTarget(c64160836.adtg)
	e2:SetValue(c64160836.adval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
c64160836.counter_add_list={0x100e}
function c64160836.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:IsControler(1-tp) then
			tc:AddCounter(0x100e,1)
		end
		tc=eg:GetNext()
	end
end
function c64160836.adcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c64160836.adtg(e,c)
	local bc=c:GetBattleTarget()
	return bc and c:GetCounter(0x100e)~=0 and bc:IsSetCard(0xc)
end
function c64160836.adval(e,c)
	return c:GetCounter(0x100e)*-300
end
