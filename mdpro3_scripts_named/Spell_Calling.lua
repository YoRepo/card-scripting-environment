--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 神召魔法  (ID: 41160595)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方控制的魔法·陷阱卡的效果把盖放的这张卡破坏送去墓地时，从卡组选择1张速攻魔法卡给双方确认并在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--コーリング・マジック
function c41160595.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41160595,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c41160595.setcon)
	e1:SetOperation(c41160595.setop)
	c:RegisterEffect(e1)
end
function c41160595.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(r,0x41)==0x41 and rp==1-tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEDOWN)
end
function c41160595.filter(c)
	return c:GetType()==TYPE_SPELL+TYPE_QUICKPLAY and c:IsSSetable()
end
function c41160595.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c41160595.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
