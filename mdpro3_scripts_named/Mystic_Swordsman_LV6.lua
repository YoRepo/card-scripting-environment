--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 谜之剑士 LV6  (ID: 60482781)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 2300 | DEF 1700
-- Setcode: 65
--
-- Effect Text:
-- 这张卡通常召唤的场合，必须以里侧守备表示的形式出场。攻击里侧守备表示的怪兽时，不进行伤害计算，那只怪兽以里侧守备表示的状态直接破坏。此效果破坏的怪兽可以不送去墓地，放到对方卡组的最上面。
--[[ __CARD_HEADER_END__ ]]

--ミスティック・ソードマン LV6
function c60482781.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60482781,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c60482781.descon)
	e1:SetTarget(c60482781.destg)
	e1:SetOperation(c60482781.desop)
	c:RegisterEffect(e1)
	--summon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e2:SetCondition(c60482781.sumcon)
	c:RegisterEffect(e2)
end
c60482781.lvdn={47507260,74591968}
function c60482781.descon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==Duel.GetAttacker() and d and d:IsFacedown() and d:IsDefensePos()
end
function c60482781.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttackTarget(),1,0,0)
end
function c60482781.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		if d:GetOwner()~=tp and Duel.SelectYesNo(tp,aux.Stringid(60482781,1)) then
			Duel.Destroy(d,REASON_EFFECT,LOCATION_DECK)
		else
			Duel.Destroy(d,REASON_EFFECT)
		end
	end
end
function c60482781.sumcon(e,c,minc)
	if not c then return true end
	return false
end
