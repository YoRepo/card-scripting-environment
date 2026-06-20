--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 妖龙 摩诃摩  (ID: 545781)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Dragon
-- Level 5
-- ATK 0 | DEF 2500
--
-- Effect Text:
-- ①：对方回合，自己或者对方受到战斗伤害时才能发动。这张卡从手卡特殊召唤。那之后，从以下效果选1个适用。
-- ●自己基本分回复那次战斗伤害的数值。
-- ●给与对方那次战斗伤害数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--妖竜マハーマ
function c545781.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(545781,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c545781.sumcon)
	e1:SetTarget(c545781.sumtg)
	e1:SetOperation(c545781.sumop)
	c:RegisterEffect(e1)
end
function c545781.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function c545781.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c545781.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
		local opt=Duel.SelectOption(tp,aux.Stringid(545781,0),aux.Stringid(545781,1))
		if opt==0 then
			Duel.Recover(tp,ev,REASON_EFFECT)
		else
			Duel.Damage(1-tp,ev,REASON_EFFECT)
		end
	end
end
