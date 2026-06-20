--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 神艺学的消失-改变-  (ID: 74011784)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 461
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从自己的卡组·墓地把1张「神艺学都 神艺学园」在自己的场地区域表侧表示放置。自己场上有「神艺学都 神艺学园」存在的场合，作为代替从卡组把「神艺学的消失-改变-」以外的1张「神艺」卡加入手卡。
-- ②：自己的「神艺」怪兽被选择作为攻击对象时，把墓地的这张卡除外才能发动。那次攻击无效。那之后，可以从手卡把1只「无垢者 米底乌斯」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--アルトメギア・バーニッシュ－改変－
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,97556336,74733322)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.negcon)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(s.negop)
	c:RegisterEffect(e2)
end
function s.stfilter(c,tp)
	return c:IsCode(74733322) and not c:IsForbidden() and c:CheckUniqueOnField(tp)
end
function s.thfilter(c)
	return not c:IsCode(id) and c:IsSetCard(0x1cd) and c:IsAbleToHand()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsCode),tp,LOCATION_ONFIELD,0,1,nil,74733322) then
			return Duel.IsExistingMatchingCard(s.stfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,tp)
		else
			return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
		end
	end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsCode),tp,LOCATION_ONFIELD,0,1,nil,74733322) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.stfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
		if tc then
			local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc then
				Duel.SendtoGrave(fc,REASON_RULE)
				Duel.BreakEffect()
			end
			Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsFaceup() and tc:IsSetCard(0x1cd)
		and tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE)
end
function s.spfilter(c,e,tp)
	return c:IsCode(97556336) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if #g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
