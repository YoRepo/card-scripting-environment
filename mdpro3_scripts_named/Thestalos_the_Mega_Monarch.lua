--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Thestalos the Mega Monarch  (ID: 69230391)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 8
-- ATK 2800 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute Summon this card by Tributing 1 Tribute Summoned monster.
-- If this card is Tribute Summoned: Look at your opponent's hand and discard 1 card from their hand,
-- then, if it was a monster, inflict damage to your opponent equal to its original Level x 200.
-- If this card was Tribute Summoned by Tributing a FIRE monster, add this additional effect.
-- ● Also, inflict 1000 damage to your opponent after that.
--[[ __CARD_HEADER_END__ ]]

--爆炎帝テスタロス
function c69230391.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69230391,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c69230391.otcon)
	e1:SetOperation(c69230391.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--handes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(69230391,1))
	e3:SetCategory(CATEGORY_HANDES_OPPO+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c69230391.condition)
	e3:SetTarget(c69230391.target)
	e3:SetOperation(c69230391.operation)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MATERIAL_CHECK)
	e4:SetValue(c69230391.valcheck)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
end
function c69230391.otfilter(c)
	return c:IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c69230391.otcon(e,c,minc)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c69230391.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return c:IsLevelAbove(7) and minc<=1 and Duel.CheckTribute(c,1,1,mg)
end
function c69230391.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c69230391.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
function c69230391.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c69230391.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	if e:GetLabel()==1 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
	end
end
function c69230391.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local hg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(hg,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(1-tp)
		local tc=hg:GetFirst()
		if tc:IsType(TYPE_MONSTER) then
			Duel.Damage(1-tp,tc:GetLevel()*200,REASON_EFFECT)
		end
	end
	if e:GetLabel()==1 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
function c69230391.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_FIRE) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
