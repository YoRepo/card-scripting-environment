--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 御用王  (ID: 84305651)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 8
-- ATK 2800 | DEF 2000
--
-- Effect Text:
-- 调整＋调整以外的同调怪兽1只以上
-- ①：这张卡向对方怪兽攻击的攻击宣言时发动。这张卡的攻击力直到伤害步骤结束时上升自己场上的战士族·地属性的同调怪兽数量×400。
-- ②：这张卡战斗破坏对方怪兽送去墓地时，可以从以下效果选择1个发动。
-- ●破坏的那只怪兽在自己场上特殊召唤。
-- ●选对方场上1只表侧表示怪兽得到控制权。
--[[ __CARD_HEADER_END__ ]]

--ゴヨウ・キング
function c84305651.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSynchroType,TYPE_SYNCHRO),1)
	c:EnableReviveLimit()
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84305651,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c84305651.atkcon)
	e1:SetOperation(c84305651.atkop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCondition(aux.bdogcon)
	e2:SetTarget(c84305651.sptg)
	e2:SetOperation(c84305651.spop)
	c:RegisterEffect(e2)
end
c84305651.material_type=TYPE_SYNCHRO
function c84305651.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c84305651.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local ct=Duel.GetMatchingGroupCount(c84305651.filter,tp,LOCATION_MZONE,0,nil)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*400)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
	end
end
function c84305651.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsType(TYPE_SYNCHRO)
end
function c84305651.ctfilter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c84305651.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	local b1=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and bc:IsCanBeSpecialSummoned(e,0,tp,false,false)
	local b2=Duel.IsExistingMatchingCard(c84305651.ctfilter,tp,0,LOCATION_MZONE,1,nil)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(84305651,1),aux.Stringid(84305651,2))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(84305651,1))
	else
		op=Duel.SelectOption(tp,aux.Stringid(84305651,2))+1
	end
	if op==0 then
		Duel.SetTargetCard(bc)
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,bc,1,0,0)
	else
		e:SetCategory(CATEGORY_CONTROL)
	end
	e:SetLabel(op)
end
function c84305651.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		local g=Duel.SelectMatchingCard(tp,c84305651.ctfilter,tp,0,LOCATION_MZONE,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.GetControl(tc,tp)
		end
	end
end
