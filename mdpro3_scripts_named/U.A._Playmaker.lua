--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 超级运动员 四分卫球员  (ID: 98229575)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 8
-- ATK 2600 | DEF 2000
-- Setcode: 178
--
-- Effect Text:
-- 「超级运动员 四分卫球员」的①的方法的特殊召唤1回合只能有1次。
-- ①：这张卡可以让「超级运动员 四分卫球员」以外的自己场上1只「超级运动员」怪兽回到手卡，从手卡特殊召唤。
-- ②：这张卡以外的自己的「超级运动员」怪兽的攻击宣言时才能发动。这张卡的攻击力下降800，自己的攻击怪兽的攻击力上升800。
--[[ __CARD_HEADER_END__ ]]

--U.A.フィールドゼネラル
function c98229575.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,98229575+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c98229575.spcon)
	e1:SetTarget(c98229575.sptg)
	e1:SetOperation(c98229575.spop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c98229575.atkcon)
	e2:SetOperation(c98229575.atkop)
	c:RegisterEffect(e2)
end
function c98229575.spfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xb2) and not c:IsCode(98229575) and c:IsAbleToHandAsCost()
		and Duel.GetMZoneCount(tp,c)>0
end
function c98229575.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c98229575.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil,tp)
end
function c98229575.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c98229575.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c98229575.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,nil,REASON_SPSUMMON)
end
function c98229575.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsSetCard(0xb2) and at:IsControler(tp) and at~=e:GetHandler() and e:GetHandler():IsAttackAbove(800)
end
function c98229575.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local at=Duel.GetAttacker()
	if c:IsFaceup() and c:IsRelateToEffect(e) and c:IsAttackAbove(800) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		if at:IsFaceup() and at:IsRelateToBattle() then
			local e2=e1:Clone()
			e2:SetValue(800)
			at:RegisterEffect(e2)
		end
	end
end
