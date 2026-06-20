--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 马达贝壳  (ID: 78394032)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1300 | DEF 1800
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡从场上送去墓地的场合才能发动。在自己场上把1只「马达衍生物」（机械族·地·1星·攻/守200）攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--モーターシェル
function c78394032.initial_effect(c)
	aux.AddCodeList(c,82556059)
	--"Motor Token" Summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,78394032)
	e1:SetCondition(c78394032.tkcon)
	e1:SetTarget(c78394032.tktg)
	e1:SetOperation(c78394032.tkop)
	c:RegisterEffect(e1)
end
function c78394032.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c78394032.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,78394033,0,TYPES_TOKEN_MONSTER,200,200,1,RACE_MACHINE,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c78394032.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,78394033,0,TYPES_TOKEN_MONSTER,200,200,1,RACE_MACHINE,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) then
		local token=Duel.CreateToken(tp,78394033)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
