--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 结合术-D2O  (ID: 79402185)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 256
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把自己的手卡·场上2只「氘素龙」和1只「氧素龙」解放才能发动。从自己的手卡·卡组·墓地选1只「水龙」或者「水龙-团簇」当作「结合术-H2O」的效果特殊召唤。
-- ②：这张卡在墓地存在，「水龙」或者「水龙-团簇」从场上送去自己墓地的场合发动。墓地的这张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--ボンディング－D2O
function c79402185.initial_effect(c)
	aux.AddCodeList(c,43017476,58071123,6022371,85066822)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c79402185.cost)
	e1:SetTarget(c79402185.target)
	e1:SetOperation(c79402185.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,79402185)
	e2:SetCondition(c79402185.thcon)
	e2:SetTarget(c79402185.thtg)
	e2:SetOperation(c79402185.thop)
	c:RegisterEffect(e2)
end
c79402185.spchecks=aux.CreateChecks(Card.IsCode,{43017476,43017476,58071123})
function c79402185.costfilter(c,tp)
	return c:IsCode(43017476,58071123) and (c:IsControler(tp) or c:IsFaceup())
end
function c79402185.fgoal(g,tp)
	return Duel.GetMZoneCount(tp,g)>0 and Duel.CheckReleaseGroupEx(tp,aux.IsInGroup,#g,REASON_COST,true,nil,g)
end
function c79402185.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	local g=Duel.GetReleaseGroup(tp,true):Filter(c79402185.costfilter,nil,tp)
	if chk==0 then return g:CheckSubGroupEach(c79402185.spchecks,c79402185.fgoal,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg=g:SelectSubGroupEach(tp,c79402185.spchecks,false,c79402185.fgoal,tp)
	aux.UseExtraReleaseCount(rg,tp)
	Duel.Release(rg,REASON_COST)
end
function c79402185.filter(c,e,tp)
	return c:IsCode(85066822,6022371) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c79402185.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local res=e:GetLabel()==1 or Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chk==0 then
		e:SetLabel(0)
		return res and Duel.IsExistingMatchingCard(c79402185.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c79402185.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c79402185.filter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
function c79402185.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c79402185.thfilter,1,nil) and not eg:IsContains(e:GetHandler())
end
function c79402185.thfilter(c)
	return (c:IsCode(85066822) or c:IsCode(6022371)) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c79402185.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c79402185.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
