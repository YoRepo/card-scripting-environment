--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 齿轮齿轮攻击人  (ID: 72370114)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1900 | DEF 100
-- Setcode: 114
--
-- Effect Text:
-- 这张卡1回合只有1次可以变成里侧守备表示。这张卡反转时，可以选最多有这张卡以外的自己场上的名字带有「齿轮齿轮」的怪兽数量的场上的魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ギアギアタッカー
function c72370114.initial_effect(c)
	--turn set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72370114,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c72370114.target)
	e1:SetOperation(c72370114.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72370114,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_FLIP)
	e2:SetTarget(c72370114.destg)
	e2:SetOperation(c72370114.desop)
	c:RegisterEffect(e2)
end
function c72370114.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(72370114)==0 end
	c:RegisterFlagEffect(72370114,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c72370114.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c72370114.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x72)
end
function c72370114.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c72370114.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72370114.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c72370114.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c72370114.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c72370114.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c72370114.cfilter,tp,LOCATION_MZONE,0,aux.ExceptThisCard(e))
	local g=Duel.GetMatchingGroup(c72370114.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if ct>0 and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,1,ct,nil)
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
