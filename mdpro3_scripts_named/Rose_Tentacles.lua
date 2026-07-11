--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Rose Tentacles  (ID: 41160533)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 6
-- ATK 2200 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- At the start of your Battle Phase, for each Plant monster your opponent currently controls, this
-- card gains 1 additional attack during each Battle Phase this turn.
-- Each time this card destroys a Plant monster by battle: Inflict 300 damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--ローズ・テンタクルス
function c41160533.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c41160533.maop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(41160533,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCondition(c41160533.damcon)
	e3:SetTarget(c41160533.damtg)
	e3:SetOperation(c41160533.damop)
	c:RegisterEffect(e3)
end
function c41160533.mfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c41160533.maop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local ct=Duel.GetMatchingGroupCount(c41160533.mfilter,tp,0,LOCATION_MZONE,nil)
	if ct~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_BATTLE)
		e:GetHandler():RegisterEffect(e1)
	end
end
function c41160533.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget():IsRace(RACE_PLANT)
end
function c41160533.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c41160533.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
