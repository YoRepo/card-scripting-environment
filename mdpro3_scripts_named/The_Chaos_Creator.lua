--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 混沌创世神  (ID: 90488465)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Thunder
-- Level 8
-- ATK 2300 | DEF 3000
-- Setcode: 207
--
-- Effect Text:
-- 这张卡不能通常召唤。从自己墓地把光属性和暗属性的怪兽各1只除外的场合可以特殊召唤。这个卡名的效果1回合只能使用1次。
-- ①：从手卡特殊召唤的这张卡存在的场合，从除外的自己以及对方的怪兽之中以合计3只为对象才能发动（同名卡最多1张）。那之内的1只在自己场上特殊召唤，剩余用喜欢的顺序回到持有者卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--混沌の創世神
function c90488465.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90488465.spcon)
	e1:SetTarget(c90488465.sptg)
	e1:SetOperation(c90488465.spop)
	c:RegisterEffect(e1)
	--todeck and special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90488465,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,90488465)
	e2:SetCondition(c90488465.tdcon)
	e2:SetTarget(c90488465.tdtg)
	e2:SetOperation(c90488465.tdop)
	c:RegisterEffect(e2)
end
function c90488465.spcostfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
end
function c90488465.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetMZoneCount(tp)<=0 then return false end
	local g=Duel.GetMatchingGroup(c90488465.spcostfilter,tp,LOCATION_GRAVE,0,nil)
	return g:CheckSubGroup(aux.gfcheck,2,2,Card.IsAttribute,ATTRIBUTE_LIGHT,ATTRIBUTE_DARK)
end
function c90488465.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c90488465.spcostfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:SelectSubGroup(tp,aux.gfcheck,true,2,2,Card.IsAttribute,ATTRIBUTE_LIGHT,ATTRIBUTE_DARK)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c90488465.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local sg=e:GetLabelObject()
	Duel.Remove(sg,POS_FACEUP,REASON_SPSUMMON)
	sg:DeleteGroup()
end
function c90488465.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL) and e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function c90488465.tdfilter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
		and (c:IsAbleToDeck() or c:IsCanBeSpecialSummoned(e,0,tp,false,false))
end
function c90488465.fselect(g,e,tp)
	return aux.dncheck(g) and g:IsExists(Card.IsAbleToDeck,2,nil) and g:IsExists(Card.IsCanBeSpecialSummoned,1,nil,e,0,tp,false,false)
end
function c90488465.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local dg=Duel.GetMatchingGroup(c90488465.tdfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil,e,tp)
	if chkc then return false end
	if chk==0 then return dg:CheckSubGroup(c90488465.fselect,3,3,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=dg:SelectSubGroup(tp,c90488465.fselect,false,3,3,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c90488465.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90488465.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=tg:FilterSelect(tp,c90488465.spfilter,1,1,nil,e,tp)
		if sg:GetCount()>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			tg:Sub(sg)
			aux.PlaceCardsOnDeckBottom(tp,tg)
		end
	end
end
