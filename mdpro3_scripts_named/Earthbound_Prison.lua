--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 地缚牢  (ID: 71089030)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 33
--
-- Effect Text:
-- ①：这张卡的发动时，可以以对方场上1只效果怪兽为对象。那个场合，这张卡得到以下效果。
-- ●只要这张卡在场地区域存在，作为对象的效果怪兽的效果无效化。
-- ②：自己在通常召唤外加上只有1次，自己主要阶段可以把1只「地缚」怪兽召唤。
-- ③：这张卡被对方的效果破坏的场合，若自己的场上或墓地有「地缚」怪兽存在则发动。对方基本分变成一半，对方场上的全部表侧表示卡的效果直到回合结束时无效。
--[[ __CARD_HEADER_END__ ]]

--地縛牢
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetTarget(s.distg)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_TARGET)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_FZONE)
	c:RegisterEffect(e1)
	--add normal summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x21))
	c:RegisterEffect(e2)
	--halve lp
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(s.hlpcon)
	e3:SetTarget(s.hlptg)
	e3:SetOperation(s.hlpop)
	c:RegisterEffect(e3)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and aux.NegateEffectMonsterFilter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(aux.NegateEffectMonsterFilter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.SelectEffectYesNo(tp,e:GetHandler(),aux.Stringid(id,2)) then
		e:SetCategory(CATEGORY_DISABLE)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(s.disop)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
		local g=Duel.SelectTarget(tp,aux.NegateEffectMonsterFilter,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then c:SetCardTarget(tc) end
end
function s.filter(c)
	return c:IsFaceupEx() and c:IsSetCard(0x21) and c:IsType(TYPE_MONSTER)
end
function s.hlpcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousControler(tp) and rp==1-tp and c:IsReason(REASON_EFFECT)
end
function s.hlptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(aux.NegateAnyFilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,#g,0,0)
end
function s.hlpop(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(1-tp)
	Duel.SetLP(1-tp,math.ceil(lp/2))
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.NegateAnyFilter,tp,0,LOCATION_ONFIELD,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=e1:Clone()
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			tc:RegisterEffect(e3)
		end
	end
end
