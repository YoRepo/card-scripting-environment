--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 超重型炮塔列车 古斯塔夫火箭大炮  (ID: 92359409)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Machine
-- Rank 10
-- ATK 5000 | DEF 3000
--
-- Effect Text:
-- 10星怪兽×3
-- 「超重型炮塔列车 古斯塔夫火箭大炮」1回合1次也能丢弃1张手卡，在自己场上的「超重型炮塔列车 古斯塔夫最大炮」上面重叠来超量召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡持有超量素材，对方把怪兽的效果发动时才能发动。那个效果无效并破坏。那之后，给与对方1000伤害。
-- ②：自己结束阶段发动。这张卡1个超量素材取除或这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--超弩級砲塔列車グスタフ・ロケット
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,56910167)
	aux.AddXyzProcedure(c,nil,10,3,s.ovfilter,aux.Stringid(id,0),3,s.xyzop)
	c:EnableReviveLimit()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.discon)
	e1:SetTarget(s.distg)
	e1:SetOperation(s.disop)
	c:RegisterEffect(e1)
	--remove material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,2))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(s.rmcon)
	e2:SetOperation(s.rmop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsDiscardable(REASON_SPSUMMON)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsCode(56910167)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,s.cfilter,1,1,REASON_COST+REASON_DISCARD)
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainDisablable(ev)
		and c:GetOverlayCount()>0 and ep==1-tp and re:IsActiveType(TYPE_MONSTER)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
	end
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToChain(ev)
		and Duel.Destroy(eg,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetOverlayCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	else
		Duel.Destroy(c,REASON_EFFECT)
	end
end
