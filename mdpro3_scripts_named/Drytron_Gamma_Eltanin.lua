--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 龙辉巧-天棓四γ  (ID: 60037599)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 2000 | DEF 0
-- Setcode: 340
--
-- Effect Text:
-- 这张卡不能通常召唤，用「龙辉巧」卡的效果才能特殊召唤。这个卡名的效果1回合只能使用1次。
-- ①：把这张卡以外的自己的手卡·场上1只「龙辉巧」怪兽或仪式怪兽解放才能发动（这个效果发动的回合，自己若非不能通常召唤的怪兽则不能特殊召唤）。这张卡从手卡·墓地守备表示特殊召唤。那之后，可以从自己墓地把
-- 「龙辉巧-天棓四γ」以外的1只攻击力2000的「龙辉巧」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－エルγ
function c60037599.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c60037599.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c60037599.extraop)
	e2:SetDescription(aux.Stringid(60037599,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e2:SetCountLimit(1,60037599)
end
function c60037599.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c60037599.rbfilter(c,e,tp)
	return c:IsSetCard(0x154) and c:IsAttack(2000) and not c:IsCode(60037599) and c:IsCanBeSpecialSummoned(e,0,tp,false,aux.DrytronSpSummonType(c))
end
function c60037599.extraop(e,tp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c60037599.rbfilter),tp,LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(60037599,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		local sc=sg:GetFirst()
		if Duel.SpecialSummon(sg,0,tp,tp,false,aux.DrytronSpSummonType(sc),POS_FACEUP)~=0 and aux.DrytronSpSummonType(sc) then
			sc:CompleteProcedure()
		end
	end
end
