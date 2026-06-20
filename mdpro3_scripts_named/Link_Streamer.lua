--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 连接流式鸟  (ID: 23331400)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 4
-- ATK 1600 | DEF 1800
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡已在怪兽区域存在的状态，自己场上有电子界族怪兽召唤·特殊召唤时才能发动。在自己场上把1只「数据衍生物」（电子界族·光·1星·攻/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リンク・ストリーマー
function c23331400.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,23331400)
	e1:SetCondition(c23331400.tkcon)
	e1:SetTarget(c23331400.tktg)
	e1:SetOperation(c23331400.tkop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c23331400.cfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE) and c:IsControler(tp)
end
function c23331400.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23331400.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c23331400.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,23331401,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c23331400.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,23331401,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_LIGHT) then
		local token=Duel.CreateToken(tp,23331401)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
