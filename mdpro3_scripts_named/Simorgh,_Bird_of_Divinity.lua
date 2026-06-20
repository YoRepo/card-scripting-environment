--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 神鸟 斯摩夫  (ID: 14989021)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 7
-- ATK 2700 | DEF 1000
-- Setcode: 301
--
-- Effect Text:
-- 这张卡不能特殊召唤。这张卡上级召唤的场合，解放的怪兽必须是风属性怪兽。只要这张卡在场上表侧表示存在，双方玩家在每次双方的结束阶段受到1000分伤害。这个时候，各自玩家受到的伤害变少魔法·陷阱卡控制数量
-- ×500的数值。
--[[ __CARD_HEADER_END__ ]]

--神鳥シムルグ
function c14989021.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--tribute limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRIBUTE_LIMIT)
	e2:SetValue(c14989021.tlimit)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(14989021,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c14989021.damtg)
	e3:SetOperation(c14989021.damop)
	c:RegisterEffect(e3)
end
function c14989021.tlimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WIND)
end
function c14989021.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c14989021.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c14989021.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c1=Duel.GetMatchingGroupCount(c14989021.filter,tp,LOCATION_ONFIELD,0,nil)
	if c1<2 then
		Duel.Damage(tp,1000-c1*500,REASON_EFFECT)
	end
	local c2=Duel.GetMatchingGroupCount(c14989021.filter,1-tp,LOCATION_ONFIELD,0,nil)
	if c2<2 then
		Duel.Damage(1-tp,1000-c2*500,REASON_EFFECT)
	end
end
