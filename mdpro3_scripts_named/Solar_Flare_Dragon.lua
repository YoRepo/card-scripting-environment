--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 日珥龙  (ID: 45985838)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1500 | DEF 1000
--
-- Effect Text:
-- 若自己场上有除这张卡以外的炎族怪兽存在，则这张卡不能被攻击。在自己的每回合的结束阶段，给与对方基本分500分的伤害。
--[[ __CARD_HEADER_END__ ]]

--プロミネンス・ドラゴン
function c45985838.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c45985838.atklm)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45985838,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c45985838.condition)
	e2:SetTarget(c45985838.target)
	e2:SetOperation(c45985838.operation)
	c:RegisterEffect(e2)
end
function c45985838.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PYRO)
end
function c45985838.atklm(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c45985838.filter,c:GetControler(),LOCATION_MZONE,0,1,c)
end
function c45985838.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c45985838.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c45985838.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
