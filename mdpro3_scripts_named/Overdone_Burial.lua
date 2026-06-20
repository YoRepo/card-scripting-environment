--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 过火的埋葬  (ID: 65993085)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从手卡丢弃1只怪兽，以原本等级比丢弃的怪兽低的自己墓地1只怪兽为对象才能把这张卡发动。那只怪兽特殊召唤，把这张卡装备。
-- ②：装备怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--やりすぎた埋葬
function c65993085.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,65993085+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c65993085.cost)
	e1:SetTarget(c65993085.target)
	e1:SetOperation(c65993085.operation)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
end
function c65993085.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c65993085.costfilter(c,e,tp)
	local lv=c:GetOriginalLevel()
	return lv>1 and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
		and Duel.IsExistingTarget(c65993085.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,lv)
end
function c65993085.spfilter(c,e,tp,lv)
	return c:IsLevelBelow(lv-1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65993085.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c65993085.spfilter(chkc,e,tp,e:GetLabel()) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c65993085.costfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local cg=Duel.SelectMatchingCard(tp,c65993085.costfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SendtoGrave(cg,REASON_DISCARD+REASON_COST)
	local lv=cg:GetFirst():GetLevel()
	e:SetLabel(lv)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c65993085.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c65993085.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
			Duel.Equip(tp,c,tc)
			--Add Equip limit
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(c65993085.eqlimit)
			e1:SetLabelObject(tc)
			c:RegisterEffect(e1)
		end
	end
end
function c65993085.eqlimit(e,c)
	return e:GetLabelObject()==c
end
