--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 自然豆一族  (ID: 44789585)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 2
-- ATK 100 | DEF 1200
-- Setcode: 42
--
-- Effect Text:
-- 这张卡1回合只有1次不会被战斗破坏。场上表侧表示存在的这张卡被选择作为攻击对象时，给与对方基本分500分伤害。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ビーンズ
function c44789585.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c44789585.valcon)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44789585,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetTarget(c44789585.damtg)
	e2:SetOperation(c44789585.damop)
	c:RegisterEffect(e2)
end
function c44789585.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c44789585.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c44789585.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
