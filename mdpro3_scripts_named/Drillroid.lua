--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 钻头机人  (ID: 71218746)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 1600
-- Setcode: 22
--
-- Effect Text:
-- ①：这张卡向守备表示怪兽攻击的伤害计算前发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ドリルロイド
function c71218746.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71218746,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetTarget(c71218746.targ)
	e1:SetOperation(c71218746.op)
	c:RegisterEffect(e1)
end
function c71218746.targ(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler() and t~=nil and not t:IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,t,1,0,0)
end
function c71218746.op(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetAttackTarget()
	if t~=nil and t:IsRelateToBattle() and not t:IsAttackPos() then
		Duel.Destroy(t,REASON_EFFECT)
	end
end
