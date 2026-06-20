--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 溢出龙  (ID: 76589546)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：场上的怪兽被效果破坏时才能发动。这张卡从手卡特殊召唤。2只以上的场上的怪兽被效果破坏时发动的场合，可以再在自己场上把1只「溢出衍生物」（龙族·暗·1星·攻/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--オーバーフロー・ドラゴン
function c76589546.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76589546,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,76589546)
	e1:SetCondition(c76589546.spcon)
	e1:SetTarget(c76589546.sptg)
	e1:SetOperation(c76589546.spop)
	c:RegisterEffect(e1)
end
function c76589546.cfilter(c)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsReason(REASON_EFFECT)
end
function c76589546.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c76589546.cfilter,nil)
	e:SetLabel(ct)
	return ct>0
end
function c76589546.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c76589546.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0
		and e:GetLabel()>=2 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,76589547,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_DRAGON,ATTRIBUTE_DARK)
		and Duel.SelectYesNo(tp,aux.Stringid(76589546,1)) then
		Duel.BreakEffect()
		local token=Duel.CreateToken(tp,76589547)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
