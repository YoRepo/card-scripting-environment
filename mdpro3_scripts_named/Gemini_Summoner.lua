--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 二重召唤师  (ID: 19041767)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 0
--
-- Effect Text:
-- 对方的结束阶段时只有1次支付500基本分才能发动。把手卡或者自己场上表侧表示存在的1只二重怪兽通常召唤。此外，这张卡1回合只有1次不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--デュアル・サモナー
function c19041767.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c19041767.valcon)
	c:RegisterEffect(e1)
	--instant
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19041767,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c19041767.condition)
	e2:SetCost(c19041767.cost)
	e2:SetTarget(c19041767.target)
	e2:SetOperation(c19041767.operation)
	c:RegisterEffect(e2)
end
function c19041767.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c19041767.filter(c)
	return c:IsType(TYPE_DUAL) and (c:IsSummonable(true,nil) or c:IsMSetable(true,nil))
end
function c19041767.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c19041767.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c19041767.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19041767.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c19041767.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c19041767.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local s1=tc:IsSummonable(true,nil)
		local s2=tc:IsMSetable(true,nil)
		if (s1 and s2 and Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)==POS_FACEUP_ATTACK) or not s2 then
			Duel.Summon(tp,tc,true,nil)
		else
			Duel.MSet(tp,tc,true,nil)
		end
	end
end
