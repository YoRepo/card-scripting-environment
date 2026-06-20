--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 烙印之剑  (ID: 81767888)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 349
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：从自己墓地把「烙印」魔法·陷阱卡任意数量除外才能发动。除外数量的「冰剑衍生物」（龙族·暗·8星·攻2500/守2000）在自己场上特殊召唤。
-- ②：把墓地的这张卡除外，以自己的除外状态的1只「阿不思的落胤」或者有那个卡名记述的怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--烙印の剣
function c81767888.initial_effect(c)
	aux.AddCodeList(c,68468459)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,81767888)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c81767888.spcost)
	e1:SetTarget(c81767888.sptg)
	e1:SetOperation(c81767888.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1,81767888)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c81767888.thtg)
	e2:SetOperation(c81767888.thop)
	c:RegisterEffect(e2)
end
function c81767888.costfilter(c)
	return c:IsSetCard(0x15d) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemoveAsCost()
end
function c81767888.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c81767888.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then
		if e:GetLabel()==0 then return false end
		e:SetLabel(0)
		return ft>0 and Duel.IsExistingMatchingCard(c81767888.costfilter,tp,LOCATION_GRAVE,0,1,nil)
			and Duel.IsPlayerCanSpecialSummonMonster(tp,81767889,0,TYPES_TOKEN_MONSTER,2500,2000,8,RACE_DRAGON,ATTRIBUTE_DARK)
	end
	e:SetLabel(0)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c81767888.costfilter,tp,LOCATION_GRAVE,0,1,ft,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(#g)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,#g,0,0)
end
function c81767888.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ct>ft or not Duel.IsPlayerCanSpecialSummonMonster(tp,81767889,0,TYPES_TOKEN_MONSTER,2500,2000,8,RACE_DRAGON,ATTRIBUTE_DARK) then return end
	if ct>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	for i=1,ct do
		local token=Duel.CreateToken(tp,81767889)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c81767888.thfilter(c)
	return (c:IsCode(68468459) or aux.IsCodeListed(c,68468459) and c:IsType(TYPE_MONSTER)) and c:IsFaceup() and c:IsAbleToHand()
end
function c81767888.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c81767888.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81767888.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c81767888.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c81767888.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
