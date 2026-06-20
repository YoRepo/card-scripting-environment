--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 忍者义贼 五卫五卫  (ID: 10236520)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1000
-- Setcode: 43
--
-- Effect Text:
-- 对方手卡是5张以上的场合，这张卡给与对方基本分战斗伤害时，对方手卡随机丢弃2张。
--[[ __CARD_HEADER_END__ ]]

--忍者義賊ゴエゴエ
function c10236520.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10236520,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c10236520.condition)
	e1:SetTarget(c10236520.target)
	e1:SetOperation(c10236520.operation)
	c:RegisterEffect(e1)
end
function c10236520.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>=5
end
function c10236520.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,2)
end
function c10236520.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if g:GetCount()<5 then return end
	local sg=g:RandomSelect(1-tp,2)
	Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
end
