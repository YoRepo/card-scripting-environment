--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 妖精弓手  (ID: 48742406)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 3
-- ATK 1400 | DEF 600
--
-- Effect Text:
-- 自己的主要阶段时，可以给与对方基本分自己场上表侧表示存在的光属性怪兽每1只400分伤害。这个效果发动的回合这张卡不能攻击。「妖精弓手」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--フェアリー・アーチャー
function c48742406.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48742406,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,48742406)
	e1:SetCost(c48742406.damcost)
	e1:SetTarget(c48742406.damtg)
	e1:SetOperation(c48742406.damop)
	c:RegisterEffect(e1)
end
function c48742406.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c48742406.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c48742406.dfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c48742406.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c48742406.dfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Damage(p,ct*400,REASON_EFFECT)
end
