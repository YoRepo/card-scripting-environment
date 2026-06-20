--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 正义盟军 千械鬼  (ID: 85876417)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1700 | DEF 0
-- Setcode: 1
--
-- Effect Text:
-- 这张卡可以向对方场上表侧表示存在的光属性怪兽各作1次攻击。和光属性以外的怪兽进行战斗的场合，那次伤害计算前这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--A・O・J サウザンド・アームズ
function c85876417.initial_effect(c)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(c85876417.atkfilter)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85876417,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetTarget(c85876417.destg)
	e2:SetOperation(c85876417.desop)
	c:RegisterEffect(e2)
end
function c85876417.atkfilter(e,c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c85876417.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local c=e:GetHandler()
		local a=Duel.GetAttacker()
		if a==c then a=Duel.GetAttackTarget() end
		return a and a:IsNonAttribute(ATTRIBUTE_LIGHT)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c85876417.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToBattle() then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
