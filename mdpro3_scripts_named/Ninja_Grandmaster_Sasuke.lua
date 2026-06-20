--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 忍者头领 佐助  (ID: 4041838)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1000
-- Setcode: 43
--
-- Effect Text:
-- 这张卡攻击表侧守备表示的怪兽的场合，不进入伤害计算，那只怪兽直接破坏。
--[[ __CARD_HEADER_END__ ]]

--忍者マスター SASUKE
function c4041838.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4041838,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c4041838.targ)
	e1:SetOperation(c4041838.op)
	c:RegisterEffect(e1)
end
function c4041838.targ(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler()
		and d~=nil and d:IsFaceup() and d:IsDefensePos() and d:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c4041838.op(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d~=nil and d:IsRelateToBattle() and d:IsDefensePos() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
