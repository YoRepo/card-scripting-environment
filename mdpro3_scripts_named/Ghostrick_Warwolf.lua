--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 鬼计狼人  (ID: 72913666)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 1400 | DEF 1500
-- Setcode: 141
--
-- Effect Text:
-- 自己场上有名字带有「鬼计」的怪兽存在的场合才能让这张卡表侧表示召唤。这张卡1回合只有1次可以变成里侧守备表示。此外，这张卡反转时，给与对方基本分场上盖放的卡数量×100的数值的伤害。「鬼计狼人」的这个
-- 效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・ワーウルフ
function c72913666.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c72913666.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72913666,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c72913666.postg)
	e2:SetOperation(c72913666.posop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(72913666,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetCode(EVENT_FLIP)
	e3:SetCountLimit(1,72913666)
	e3:SetTarget(c72913666.damtg)
	e3:SetOperation(c72913666.damop)
	c:RegisterEffect(e3)
end
function c72913666.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c72913666.sumcon(e)
	return not Duel.IsExistingMatchingCard(c72913666.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c72913666.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(72913666)==0 end
	c:RegisterFlagEffect(72913666,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c72913666.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c72913666.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*100)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,ct*100)
end
function c72913666.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Damage(p,ct*100,REASON_EFFECT)
end
