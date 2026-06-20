--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 年代记女巫  (ID: 54878729)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1250 | DEF 1250
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：可以从自己墓地的怪兽属性的以下效果选择1个发动。
-- ●光：除「年代记女巫」外的1只「青眼白龙」或者1张有那个卡名记述的卡从卡组送去墓地。
-- ●暗：除「年代记女巫」外的1只「黑魔术师」或者1张有那个卡名记述的卡从卡组送去墓地。
--[[ __CARD_HEADER_END__ ]]

--クロニクル・ソーサレス
function c54878729.initial_effect(c)
	aux.AddCodeList(c,89631139,46986414)
	--to graveyard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54878729,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,54878729)
	e1:SetTarget(c54878729.target)
	e1:SetOperation(c54878729.operation)
	c:RegisterEffect(e1)
end
function c54878729.filter(c,code)
	return not c:IsCode(54878729) and aux.IsCodeOrListed(c,code) and c:IsAbleToGrave()
end
function c54878729.chkfunc(g,attr,tp,code)
	return g:IsExists(Card.IsAttribute,1,nil,attr) and Duel.IsExistingMatchingCard(c54878729.filter,tp,LOCATION_DECK,0,1,nil,code)
end
function c54878729.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	local b1=c54878729.chkfunc(g,ATTRIBUTE_LIGHT,tp,89631139)
	local b2=c54878729.chkfunc(g,ATTRIBUTE_DARK,tp,46986414)
	if chk==0 then return b1 or b2 end
	local off=1
	local ops={}
	local opval={}
	if b1 then
		ops[off]=aux.Stringid(54878729,1)
		opval[off-1]=1
		off=off+1
	end
	if b2 then
		ops[off]=aux.Stringid(54878729,2)
		opval[off-1]=2
		off=off+1
	end
	local op=Duel.SelectOption(tp,table.unpack(ops))
	e:SetLabel(opval[op])
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c54878729.operation(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local code=89631139
	if opt==2 then code=46986414 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c54878729.filter,tp,LOCATION_DECK,0,1,1,nil,code)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
