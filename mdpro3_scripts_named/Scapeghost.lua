--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 替罪鬼羊  (ID: 67284107)
-- Type: Monster / Effect / Tuner / Toon
-- Attribute: DARK
-- Race: Zombie
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：这张卡反转的场合才能发动。在自己场上把「黑羊衍生物」（不死族·暗·1星·攻/守0）任意数量特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スケープ・ゴースト
function c67284107.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67284107,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c67284107.sptg)
	e1:SetOperation(c67284107.spop)
	c:RegisterEffect(e1)
end
function c67284107.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,67284108,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c67284107.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=5
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	ft=math.min(ft,(Duel.GetLocationCount(tp,LOCATION_MZONE)))
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,67284108,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) then return end
	repeat
		local token=Duel.CreateToken(tp,67284108)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		ft=ft-1
	until ft<=0 or not Duel.SelectYesNo(tp,aux.Stringid(67284107,1))
	Duel.SpecialSummonComplete()
end
