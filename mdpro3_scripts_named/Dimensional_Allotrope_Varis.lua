--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 次元同异体 多变人  (ID: 52254878)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Psychic
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡不会被和与这张卡种族或者属性相同的怪兽的战斗破坏。
-- ②：宣言种族和属性各1个才能发动。这张卡直到对方回合结束时变成宣言的种族·属性。
--[[ __CARD_HEADER_END__ ]]

--次元同異体ヴァリス
function c52254878.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c52254878.batfilter)
	c:RegisterEffect(e1)
	--att and race change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,52254878)
	e2:SetTarget(c52254878.artg)
	e2:SetOperation(c52254878.arop)
	c:RegisterEffect(e2)
end
function c52254878.batfilter(e,c)
	local bc=e:GetHandler()
	return c:IsAttribute(bc:GetAttribute()) or c:IsRace(bc:GetRace())
end
function c52254878.artg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rac=Duel.AnnounceRace(tp,1,RACE_ALL)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local att=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL)
	e:SetLabel(rac,att)
end
function c52254878.arop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rac,att=e:GetLabel()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(att)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_RACE)
		e2:SetValue(rac)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e2)
	end
end
