--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电脑网仪式  (ID: 34767865)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 280
--
-- Effect Text:
-- 电子界族仪式怪兽的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只电子界族仪式怪兽仪式召唤。
-- ②：自己场上没有怪兽存在的场合，从自己墓地把这张卡和1只仪式怪兽除外才能发动。在自己场上把2只「电脑网衍生物」（电子界族·光·4星·攻/守0）特殊召唤。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--サイバネット・リチューアル
function c34767865.initial_effect(c)
	aux.AddRitualProcGreater2(c,c34767865.ritual_filter)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetDescription(aux.Stringid(34767865,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c34767865.spcon)
	e1:SetCost(c34767865.spcost)
	e1:SetTarget(c34767865.sptg)
	e1:SetOperation(c34767865.spop)
	c:RegisterEffect(e1)
end
function c34767865.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsRace(RACE_CYBERSE)
end
function c34767865.spcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.exccon(e) and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c34767865.cfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c34767865.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c34767865.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c34767865.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c34767865.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,34767866,0,TYPES_TOKEN_MONSTER,0,0,4,RACE_CYBERSE,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,0)
end
function c34767865.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,34767866,0,TYPES_TOKEN_MONSTER,0,0,4,RACE_CYBERSE,ATTRIBUTE_LIGHT) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,34767866)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
