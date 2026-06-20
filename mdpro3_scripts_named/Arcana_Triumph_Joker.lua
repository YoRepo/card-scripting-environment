--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 天位金骑士  (ID: 93880808)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 10
-- ATK ? | DEF 2500
--
-- Effect Text:
-- ①：这张卡在手卡·墓地存在的场合，从手卡以及自己场上的表侧表示怪兽之中把「王后骑士」「卫兵骑士」「国王骑士」各1只送去墓地才能发动。这张卡特殊召唤。
-- ②：这张卡的攻击力上升双方手卡数量×500。
-- ③：丢弃1张手卡才能发动。和丢弃的卡相同种类（怪兽·魔法·陷阱）的对方场上的表侧表示的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--アルカナ トライアンフジョーカー
function c93880808.initial_effect(c)
	aux.AddCodeList(c,25652259,64788463,90876561)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93880808,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCost(c93880808.spcost)
	e1:SetTarget(c93880808.sptg)
	e1:SetOperation(c93880808.spop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c93880808.atkval)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(93880808,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c93880808.descost)
	e3:SetTarget(c93880808.destg)
	e3:SetOperation(c93880808.desop)
	c:RegisterEffect(e3)
end
c93880808.tgchecks=aux.CreateChecks(Card.IsCode,{25652259,64788463,90876561})
function c93880808.cfilter(c)
	return c:IsCode(25652259,64788463,90876561) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
end
function c93880808.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c93880808.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	if chk==0 then return g:CheckSubGroupEach(c93880808.tgchecks,aux.mzctcheck,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroupEach(tp,c93880808.tgchecks,false,aux.mzctcheck,tp)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c93880808.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c93880808.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c93880808.atkval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,LOCATION_HAND)*500
end
function c93880808.descostfilter(c,tp)
	local type=bit.band(c:GetType(),0x7)
	return c:IsDiscardable() and Duel.IsExistingMatchingCard(c93880808.desfilter,tp,0,LOCATION_ONFIELD,1,nil,type)
end
function c93880808.desfilter(c,type)
	return c:IsType(type) and c:IsFaceup()
end
function c93880808.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		e:SetLabel(100)
		return Duel.IsExistingMatchingCard(c93880808.descostfilter,tp,LOCATION_HAND,0,1,nil,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local cost=Duel.SelectMatchingCard(tp,c93880808.descostfilter,tp,LOCATION_HAND,0,1,1,nil,tp):GetFirst()
	e:SetLabel(bit.band(cost:GetType(),0x7))
	Duel.SendtoGrave(cost,REASON_COST+REASON_DISCARD)
end
function c93880808.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return true
	end
	local type=e:GetLabel()
	local g=Duel.GetMatchingGroup(c93880808.desfilter,tp,0,LOCATION_ONFIELD,nil,type)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c93880808.desop(e,tp,eg,ep,ev,re,r,rp)
	local type=e:GetLabel()
	local g=Duel.GetMatchingGroup(c93880808.desfilter,tp,0,LOCATION_ONFIELD,nil,type)
	if #g>0 then Duel.Destroy(g,REASON_EFFECT) end
end
