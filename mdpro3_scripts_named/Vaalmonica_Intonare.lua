--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 异响鸣的调律  (ID: 78598237)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 419
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从以下效果选1个适用。自己的灵摆区域没有「异响鸣」卡存在的场合，适用的效果由对方来选。
-- ●自己回复500基本分。可以特殊召唤的怪兽在自己墓地存在的场合，再让那之内的1只由对方选出，那只怪兽在自己场上特殊召唤。
-- ●自己受到500伤害。那之后，可以从自己墓地把1只4星怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ヴァルモニカ・イントナーレ
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE+CATEGORY_TOHAND+CATEGORY_GRAVE_ACTION+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.hfilter(c)
	return c:IsLevel(4) and c:IsAbleToHand()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp,op)
	if op==nil then
		local p=Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,nil,0x1a3) and tp or 1-tp
		op=aux.SelectFromOptions(p,{true,aux.Stringid(id,1)},{true,aux.Stringid(id,2)})
	end
	if op==1 then
		if Duel.Recover(tp,500,REASON_EFFECT)<1 then return end
		local g=Duel.SelectMatchingCard(1-tp,s.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		if #g>0 then
			Duel.BreakEffect()
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	elseif Duel.Damage(tp,500,REASON_EFFECT)>0 then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.hfilter),tp,LOCATION_GRAVE,0,nil)
		if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:Select(tp,1,1,nil)
			Duel.BreakEffect()
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
