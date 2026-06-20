--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 烈焰火星  (ID: 15033525)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 8
-- ATK 2600 | DEF 2200
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡在手卡·墓地存在的场合，从自己墓地把这张卡以外的3只怪兽除外才能发动。这张卡特殊召唤。这个效果的发动后，直到回合结束时自己不能把怪兽特殊召唤。
-- ②：自己主要阶段1，把自己场上的其他怪兽全部送去墓地才能发动。给与对方为送去墓地的怪兽数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--The blazing MARS
function c15033525.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15033525,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCost(c15033525.spcost)
	e1:SetTarget(c15033525.sptg)
	e1:SetOperation(c15033525.spop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15033525,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,15033525)
	e2:SetCondition(c15033525.damcon)
	e2:SetCost(c15033525.damcost)
	e2:SetTarget(c15033525.damtg)
	e2:SetOperation(c15033525.damop)
	c:RegisterEffect(e2)
end
function c15033525.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c15033525.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c15033525.costfilter,tp,LOCATION_GRAVE,0,3,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c15033525.costfilter,tp,LOCATION_GRAVE,0,3,3,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c15033525.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c15033525.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c15033525.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c15033525.stfilter(c)
	return c:GetOriginalType()&(TYPE_MONSTER)~=0
end
function c15033525.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	g:RemoveCard(e:GetHandler())
	local mg=g:Filter(c15033525.stfilter,nil)
	if chk==0 then return #mg>0 and not g:IsExists(aux.NOT(Card.IsAbleToGraveAsCost),1,nil) end
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(mg:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE))
end
function c15033525.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel()*500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel()*500)
end
function c15033525.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
