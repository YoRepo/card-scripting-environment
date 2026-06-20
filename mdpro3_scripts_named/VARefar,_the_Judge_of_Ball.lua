--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 蹴神-视频华利弗裁判  (ID: 19743887)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 11
-- ATK 2100 | DEF 800
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：自己场上的怪兽成为对方场上的怪兽的效果的对象时或者被选择作为对方怪兽的攻击对象时才能发动。这张卡从手卡特殊召唤。那之后，可以选那1只对方怪兽并把1张手卡给对方观看。那个场合，再让给人观看的卡种类的
-- 以下效果对选的怪兽适用。
-- ●怪兽：变成守备表示。
-- ●魔法：攻击力变成2倍。
-- ●陷阱：除外。
--[[ __CARD_HEADER_END__ ]]

--蹴神－VARefar
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.atkcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(s.tgcon)
	e2:SetTarget(s.sptg2)
	e2:SetOperation(s.spop2)
	c:RegisterEffect(e2)
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return Duel.GetAttacker():IsControler(1-tp) and at:IsControler(tp)
end
function s.cfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function s.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if rp~=1-tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return (loc&LOCATION_ONFIELD)~=0 and re:IsActiveType(TYPE_MONSTER) and g and g:IsExists(s.cfilter,1,nil,tp)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local ac=Duel.GetAttacker()
	Duel.SetTargetCard(ac)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.cfilter2(c,ac)
	return not c:IsPublic()
		and (c:IsType(TYPE_MONSTER) and ac:IsCanChangePosition() and ac:IsPosition(POS_ATTACK)
		or c:IsType(TYPE_SPELL) and ac:IsFaceup()
		or c:IsType(TYPE_TRAP) and ac:IsAbleToRemove())
end
function s.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local ac=Duel.GetFirstTarget()
		if ac and ac:IsRelateToChain() and ac:IsType(TYPE_MONSTER) then
			s.cfop(e,tp,eg,ep,ev,re,r,rp,ac)
		end
	end
end
function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(re:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local ac=Duel.GetFirstTarget()
		if ac and ac:IsRelateToChain() and ac:IsType(TYPE_MONSTER) then
			s.cfop(e,tp,eg,ep,ev,re,r,rp,ac)
		end
	end
end
function s.cfop(e,tp,eg,ep,ev,re,r,rp,ac)
	local g=Duel.GetMatchingGroup(s.cfilter2,tp,LOCATION_HAND,0,nil,ac)
	if not ac:IsLocation(LOCATION_MZONE) or not ac:IsControler(1-tp) then return end
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.BreakEffect()
		Duel.HintSelection(Group.FromCards(ac))
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
		if tc:IsType(TYPE_MONSTER) then
			Duel.ChangePosition(ac,POS_FACEUP_DEFENSE)
		elseif tc:IsType(TYPE_SPELL) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(ac:GetAttack()*2)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			ac:RegisterEffect(e1)
		elseif tc:IsType(TYPE_TRAP) then
			Duel.Remove(ac,POS_FACEUP,REASON_EFFECT)
		end
	end
end
