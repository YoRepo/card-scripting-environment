--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 静寂之圣者  (ID: 26669055)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1400 | DEF 1000
--
-- Effect Text:
-- 这张卡战斗破坏对方怪兽的场合，对方玩家在下个回合不能发动魔法卡。
--[[ __CARD_HEADER_END__ ]]

--静寂の聖者
function c26669055.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26669055,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdocon)
	e1:SetOperation(c26669055.operation)
	c:RegisterEffect(e1)
end
function c26669055.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c26669055.accon)
	e1:SetValue(c26669055.aclimit)
	e1:SetLabel(Duel.GetTurnCount())
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c26669055.accon(e)
	return e:GetLabel()~=Duel.GetTurnCount()
end
function c26669055.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
