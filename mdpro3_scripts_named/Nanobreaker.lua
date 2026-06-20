--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 纳米破坏者  (ID: 70948327)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 1800
--
-- Effect Text:
-- 这张卡攻击3星以下的表侧表示怪兽的场合，不进行伤害计算把那只怪兽直接破坏。
--[[ __CARD_HEADER_END__ ]]

--ナノブレイカー
function c70948327.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70948327,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c70948327.destg)
	e1:SetOperation(c70948327.desop)
	c:RegisterEffect(e1)
end
function c70948327.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler()
		and d~=nil and d:IsFaceup() and d:IsLevelBelow(3) and d:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c70948327.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() and d:IsFaceup() and d:IsLevelBelow(3) then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
