--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 御巫神乐  (ID: 16310544)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 397
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「御巫」仪式怪兽仪式召唤。那之后，以下效果可以适用。
-- ●把最多有自己墓地的装备魔法卡种类数量的对方场上的卡破坏，给与对方破坏数量×1000伤害。
--[[ __CARD_HEADER_END__ ]]

--御巫神楽
function c16310544.initial_effect(c)
	local e1=aux.AddRitualProcGreater2(c,c16310544.filter,LOCATION_HAND,nil,nil,true,c16310544.extraop)
	e1:SetCountLimit(1,16310544+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end
function c16310544.filter(c,e,tp)
	return c:IsSetCard(0x18d)
end
function c16310544.extraop(e,tp,eg,ep,ev,re,r,rp,tc,mat)
	if not tc then return end
	local ct=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_EQUIP):GetClassCount(Card.GetCode)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	if ct>0 and #g>0 and Duel.SelectYesNo(tp,aux.Stringid(16310544,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,ct,nil)
		Duel.HintSelection(sg)
		local res=Duel.Destroy(sg,REASON_EFFECT)
		Duel.Damage(1-tp,res*1000,REASON_EFFECT)
	end
end
