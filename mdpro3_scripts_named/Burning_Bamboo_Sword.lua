--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 燃烧的竹光  (ID: 55870497)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 96
--
-- Effect Text:
-- ①：这张卡已在魔法与陷阱区域存在的状态，自己把「竹光」卡发动的场合才能发动。下次的对方主要阶段1跳过。
--[[ __CARD_HEADER_END__ ]]

--燃え竹光
function c55870497.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(55870497,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c55870497.skipcon)
	e3:SetTarget(c55870497.skiptg)
	e3:SetOperation(c55870497.skipop)
	c:RegisterEffect(e3)
end
function c55870497.skipcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and re:GetHandler():IsSetCard(0x60)
end
function c55870497.skiptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_SKIP_M1) end
end
function c55870497.skipop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SKIP_M1)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	if Duel.GetTurnPlayer()==1-tp then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c55870497.turncon)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	end
	Duel.RegisterEffect(e1,tp)
end
function c55870497.turncon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
