--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 燃烧拳击手 击后脑勺拳手  (ID: 61679541)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 3
-- ATK 800 | DEF 1000
-- Setcode: 4228
--
-- Effect Text:
-- 这张卡向守备表示怪兽攻击的场合，不进行伤害计算把那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--BK ラビット・パンチャー
function c61679541.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61679541,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c61679541.targ)
	e1:SetOperation(c61679541.op)
	c:RegisterEffect(e1)
end
function c61679541.targ(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler()
		and d~=nil and d:IsDefensePos() and d:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c61679541.op(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d~=nil and d:IsRelateToBattle() and d:IsDefensePos() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
