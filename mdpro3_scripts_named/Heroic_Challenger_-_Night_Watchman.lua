--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 英豪挑战者 夜袭之提灯兵  (ID: 61132951)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 300
-- Setcode: 4207
--
-- Effect Text:
-- 这张卡向对方场上守备表示存在的怪兽攻击的场合，伤害计算前可以把那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--H・C 夜襲のカンテラ
function c61132951.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61132951,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetTarget(c61132951.destg)
	e1:SetOperation(c61132951.desop)
	c:RegisterEffect(e1)
end
function c61132951.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler()
		and d and d:IsDefensePos() and d:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c61132951.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d~=nil and d:IsRelateToBattle() and d:IsDefensePos() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
