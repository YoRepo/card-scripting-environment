--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 奏悦机组 阶段转换  (ID: 79859067)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 463
--
-- Effect Text:
-- 自己场上有「奏悦机组」怪兽存在，对方把怪兽的效果发动时：自己场上1只怪兽破坏，那个发动无效并破坏，那之后，自己回复2000基本分。
-- 「奏悦机组 阶段转换」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--R.B. Next Phase
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1cf)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
		and rp==1-tp
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,nil)
	if re:GetHandler():IsRelateToEffect(re) then
		g:Merge(eg)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,2000)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		if Duel.Destroy(sg,REASON_EFFECT)~=0
			and Duel.NegateActivation(ev)
			and ec:IsRelateToChain(ev)
			and Duel.Destroy(ec,REASON_EFFECT)~=0 then
			Duel.BreakEffect()
			Duel.Recover(tp,2000,REASON_EFFECT)
		end
	end
end
