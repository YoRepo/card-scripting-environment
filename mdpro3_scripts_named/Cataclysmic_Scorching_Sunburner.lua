--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 炎天祸 桑伯恩  (ID: 39505816)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Fairy
-- Level 8
-- ATK 2600 | DEF 200
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：自己场上的表侧表示的炎属性怪兽被战斗或者对方的效果破坏的场合才能发动。这张卡从手卡特殊召唤。那之后，可以选那1只破坏的自己墓地的炎属性怪兽，给与对方那个攻击力一半数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--炎天禍サンバーン
function c39505816.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39505816,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,39505816)
	e1:SetCondition(c39505816.spcon)
	e1:SetTarget(c39505816.sptg)
	e1:SetOperation(c39505816.spop)
	c:RegisterEffect(e1)
end
function c39505816.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and bit.band(c:GetPreviousAttributeOnField(),ATTRIBUTE_FIRE)~=0
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
end
function c39505816.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c39505816.cfilter,1,nil,tp)
end
function c39505816.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c39505816.damfilter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and c:GetAttack()>0 and c39505816.cfilter(c,tp)
end
function c39505816.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=eg:Filter(c39505816.damfilter,nil,tp)
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0
		and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(39505816,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
		local sg=g:Select(tp,1,1,nil)
		Duel.Damage(1-tp,math.ceil(sg:GetFirst():GetAttack()/2),REASON_EFFECT)
	end
end
